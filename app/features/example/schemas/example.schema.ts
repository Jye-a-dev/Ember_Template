import { z } from 'zod';

export const createTaskSchema = z.object({
  title: z
    .string()
    .trim()
    .min(3, 'Tiêu đề nhiệm vụ phải có ít nhất 3 ký tự')
    .max(100, 'Tiêu đề nhiệm vụ không được vượt quá 100 ký tự'),
});

export type CreateTaskSchema = z.infer<typeof createTaskSchema>;
