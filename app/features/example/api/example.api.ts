import type { TaskItem } from '../types';

export async function fetchTasksApi(): Promise<TaskItem[]> {
  await Promise.resolve();
  return [
    {
      id: '1',
      title: 'Khởi tạo cấu trúc dự án Ember Modern Polaris + Vite',
      completed: true,
      createdAt: new Date().toISOString(),
    },
    {
      id: '2',
      title: 'Tích hợp Tailwind CSS v4 và Glimmer Components (.gts)',
      completed: true,
      createdAt: new Date().toISOString(),
    },
    {
      id: '3',
      title: 'Xác thực Form bằng Zod Schema & TypeScript type-safe',
      completed: false,
      createdAt: new Date().toISOString(),
    },
  ];
}
