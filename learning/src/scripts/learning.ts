type StoredProgress = {
	completed: string[];
	quizScores: Record<string, boolean>;
};

type StoredExperimentProgress = {
	complete: boolean;
};

type AlpineMagic = {
	$watch: (property: string, callback: () => void) => void;
	$dispatch: (event: string, detail: { id: string; correct: boolean }) => void;
};

type LearningShellContext = AlpineMagic & {
	completed: string[];
	quizScores: Record<string, boolean>;
	progressKey: string;
	sectionIds: string[];
	currentSectionId: string;
	observeSections: () => void;
	currentSectionTitle: () => string;
	nextSectionId: () => string;
	nextSectionTitle: () => string;
	persist: () => void;
};

type QuizContext = AlpineMagic & {
	id: string;
	correctIndex: number;
	selected: number | null;
	submitted: boolean;
};

declare global {
	interface Window {
		Alpine: typeof import("alpinejs");
	}
}

const safeRead = (key: string): StoredProgress => {
	try {
		const value = localStorage.getItem(key);
		if (!value) return { completed: [], quizScores: {} };
		const parsed = JSON.parse(value) as Partial<StoredProgress>;
		return {
			completed: Array.isArray(parsed.completed) ? parsed.completed : [],
			quizScores: parsed.quizScores ?? {},
		};
	} catch {
		return { completed: [], quizScores: {} };
	}
};

const safeWrite = (key: string, value: StoredProgress) => {
	try {
		localStorage.setItem(key, JSON.stringify(value));
	} catch {
		// Progress is a convenience; private browsing or blocked storage should not break the lesson.
	}
};

const safeReadExperiment = (key: string): StoredExperimentProgress => {
	try {
		const value = localStorage.getItem(key);
		if (!value) return { complete: false };
		const parsed = JSON.parse(value) as Partial<StoredExperimentProgress>;
		return { complete: parsed.complete === true };
	} catch {
		return { complete: false };
	}
};

const safeWriteExperiment = (key: string, value: StoredExperimentProgress) => {
	try {
		localStorage.setItem(key, JSON.stringify(value));
	} catch {
		// Experiment status is a convenience; it must not block the protocol.
	}
};

const registerReveals = () => {
	const targets = [...document.querySelectorAll<HTMLElement>("[data-reveal]")];
	if (!("IntersectionObserver" in window)) {
		targets.forEach((target) => {
			target.classList.add("is-visible");
		});
		return;
	}

	const observer = new IntersectionObserver(
		(entries) => {
			entries
				.filter((entry) => entry.isIntersecting)
				.forEach((entry) => {
					entry.target.classList.add("is-visible");
					observer.unobserve(entry.target);
				});
		},
		{ rootMargin: "0px 0px -8% 0px", threshold: 0.01 },
	);

	targets.forEach((target) => {
		observer.observe(target);
	});
};

const registerComponents = () => {
	const Alpine = window.Alpine;
	registerReveals();

	Alpine.data("learningShell", (slug: string, sectionIds: string[]) => ({
		completed: [] as string[],
		quizScores: {} as Record<string, boolean>,
		progressKey: `learning-lab:${slug}:v1`,
		sectionIds,
		currentSectionId: sectionIds[0] ?? "",
		init(this: LearningShellContext) {
			const stored = safeRead(this.progressKey);
			this.completed = stored.completed.filter((id) => sectionIds.includes(id));
			this.quizScores = stored.quizScores;
			this.$watch("completed", () => this.persist());
			this.$watch("quizScores", () => this.persist());
			this.observeSections();
		},
		observeSections() {
			const sections = sectionIds
				.map((id) => document.getElementById(id))
				.filter((section): section is HTMLElement => section !== null);
			const update = () => {
				const marker = window.innerHeight * 0.32;
				const current = sections.reduce(
					(active, section) => (section.getBoundingClientRect().top <= marker ? section : active),
					sections[0],
				);
				if (current) this.currentSectionId = current.id;
			};
			let frame = 0;
			const onScroll = () => {
				if (frame) return;
				frame = requestAnimationFrame(() => {
					frame = 0;
					update();
				});
			};
			window.addEventListener("scroll", onScroll, { passive: true });
			update();
		},
		currentSectionTitle() {
			return document.querySelector(`#${this.currentSectionId} h2`)?.textContent ?? "Orientation";
		},
		nextSectionId() {
			const index = sectionIds.indexOf(this.currentSectionId);
			return sectionIds[index + 1] ?? sectionIds[0] ?? "";
		},
		nextSectionTitle() {
			const next = this.nextSectionId();
			return document.querySelector(`#${next} h2`)?.textContent ?? "Review the journey";
		},
		persist() {
			safeWrite(this.progressKey, {
				completed: this.completed,
				quizScores: this.quizScores,
			});
		},
		isComplete(id: string) {
			return this.completed.includes(id);
		},
		toggleComplete(id: string) {
			this.completed = this.isComplete(id)
				? this.completed.filter((item) => item !== id)
				: [...this.completed, id];
		},
		recordQuiz(detail: { id: string; correct: boolean }) {
			this.quizScores = { ...this.quizScores, [detail.id]: detail.correct };
		},
		progress() {
			return Math.round((this.completed.length / this.sectionIds.length) * 100);
		},
		resetProgress() {
			this.completed = [];
			this.quizScores = {};
		},
	}));

	Alpine.data("quiz", (id: string, correctIndex: number) => ({
		id,
		correctIndex,
		selected: null as number | null,
		submitted: false,
		choose(index: number) {
			if (!this.submitted) this.selected = index;
		},
		submit(this: QuizContext) {
			if (this.selected === null) return;
			this.submitted = true;
			this.$dispatch("quiz-complete", {
				id: this.id,
				correct: this.selected === this.correctIndex,
			});
		},
		retry() {
			this.selected = null;
			this.submitted = false;
		},
	}));

	Alpine.data("experimentShell", (paperSlug: string, experimentSlug: string) => ({
		complete: false,
		progressKey: `learning-lab:${paperSlug}:experiment:${experimentSlug}:v1`,
		init(this: { complete: boolean; progressKey: string }) {
			this.complete = safeReadExperiment(this.progressKey).complete;
		},
		isExperimentComplete(this: { complete: boolean }) {
			return this.complete;
		},
		toggleExperimentComplete(this: { complete: boolean; progressKey: string }) {
			this.complete = !this.complete;
			safeWriteExperiment(this.progressKey, { complete: this.complete });
		},
	}));

	Alpine.data("jumpRelu", () => ({
		threshold: 0.35,
		values: [0.92, 0.73, 0.58, 0.44, 0.36, 0.28, 0.19, 0.11],
		get activeCount() {
			return this.values.filter((value) => value >= this.threshold).length;
		},
		isActive(value: number) {
			return value >= this.threshold;
		},
	}));

	Alpine.data("siteExplorer", () => ({
		selected: "residual",
		focusTab(key: "residual" | "mlp" | "attention") {
			this.selected = key;
			requestAnimationFrame(() => document.getElementById(`site-tab-${key}`)?.focus());
		},
		sites: {
			residual: {
				label: "Residual stream",
				short: "The communication bottleneck",
				body: "A full representation passed between transformer blocks. Reconstruction errors here can have a larger downstream effect.",
			},
			mlp: {
				label: "MLP output",
				short: "Local feature processing",
				body: "The contribution added by the feed-forward sub-layer. A useful place to ask which features are computed locally.",
			},
			attention: {
				label: "Attention output",
				short: "Context routing",
				body: "The concatenated head outputs before the final projection. A useful place to study how context-dependent signals enter the stream.",
			},
		},
	}));
};

document.documentElement.classList.add("js");
document.addEventListener("alpine:init", registerComponents);

export {};
