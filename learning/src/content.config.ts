import { defineCollection } from "astro:content";
import { glob } from "astro/loaders";
import { z } from "astro/zod";

const sourceSchema = z.object({
	label: z.string(),
	url: z.url(),
});

const statSchema = z.object({
	value: z.string(),
	label: z.string(),
});

const quizSchema = z.object({
	prompt: z.string(),
	options: z.array(
		z.object({
			label: z.string(),
			correct: z.boolean(),
			explanation: z.string(),
		}),
	),
});

const papers = defineCollection({
	loader: glob({ pattern: "**/*.md", base: "./src/content/papers" }),
	schema: z.object({
		slug: z.string(),
		series: z.string(),
		title: z.string(),
		dek: z.string(),
		abstract: z.string(),
		stats: z.array(statSchema),
		source: sourceSchema,
		related: z.array(sourceSchema),
	}),
});

const lessons = defineCollection({
	loader: glob({ pattern: "**/*.mdx", base: "./src/content/lessons" }),
	schema: z.object({
		paperSlug: z.string(),
		id: z.string(),
		order: z.number().int().positive(),
		number: z.string(),
		kicker: z.string(),
		title: z.string(),
		summary: z.string(),
		idea: z.string(),
		bullets: z.array(z.string()),
		cues: z.object({
			remember: z.string(),
			test: z.string(),
			do: z.string(),
		}),
		callout: z.string().optional(),
		source: sourceSchema,
		quiz: quizSchema,
	}),
});

const experiments = defineCollection({
	loader: glob({ pattern: "**/*.mdx", base: "./src/content/experiments" }),
	schema: z.object({
		paperSlug: z.string(),
		slug: z.string(),
		number: z.string(),
		title: z.string(),
		purpose: z.string(),
		status: z.enum(["ready", "next", "future"]),
		estimatedTime: z.string(),
		compute: z.string(),
		prerequisites: z.array(z.string()),
		resources: z.array(sourceSchema),
		stopConditions: z.array(z.string()),
		artifacts: z.array(z.string()),
		nextSlug: z.string().optional(),
	}),
});

export const collections = { papers, lessons, experiments };
