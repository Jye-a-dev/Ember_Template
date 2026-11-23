import { z } from 'zod';

const envSchema = z.object({
  PORT: z.string().default('5000'),
  VITE_APP_URL: z.string().url().default('http://localhost:5000'),
  VITE_API_BASE_URL: z.string().url().default('http://localhost:8000/api'),
});

const rawEnv = import.meta.env as Record<string, string | undefined>;

export const env = envSchema.parse({
  PORT: rawEnv['PORT'] ?? '5000',
  VITE_APP_URL: rawEnv['VITE_APP_URL'] ?? 'http://localhost:5000',
  VITE_API_BASE_URL: rawEnv['VITE_API_BASE_URL'] ?? 'http://localhost:8000/api',
});

export type Env = z.infer<typeof envSchema>;
