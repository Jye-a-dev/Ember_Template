import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';
import type { TaskItem } from '../types';
import { fetchTasksApi } from '../api/example.api';

export default class ExampleService extends Service {
  @tracked tasks: TaskItem[] = [];
  @tracked isLoading = false;
  @tracked error: string | null = null;

  async loadTasks(): Promise<void> {
    if (this.tasks.length > 0) return;
    this.isLoading = true;
    this.error = null;
    try {
      const data = await fetchTasksApi();
      this.tasks = data;
    } catch (err) {
      this.error = err instanceof Error ? err.message : 'Lỗi không xác định';
    } finally {
      this.isLoading = false;
    }
  }

  addTask(title: string): TaskItem {
    const newTask: TaskItem = {
      id: String(Date.now()),
      title,
      completed: false,
      createdAt: new Date().toISOString(),
    };
    this.tasks = [newTask, ...this.tasks];
    return newTask;
  }

  toggleTask(id: string): void {
    this.tasks = this.tasks.map((task) =>
      task.id === id ? { ...task, completed: !task.completed } : task,
    );
  }

  deleteTask(id: string): void {
    this.tasks = this.tasks.filter((task) => task.id !== id);
  }
}

declare module '@ember/service' {
  interface Registry {
    'example-service': ExampleService;
  }
}
