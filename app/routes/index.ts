import Route from '@ember/routing/route';
import { service } from '@ember/service';
import type ExampleService from '@/features/example/services/example-service';

export default class IndexRoute extends Route {
  @service('example-service') declare exampleService: ExampleService;

  async model(): Promise<void> {
    await this.exampleService.loadTasks();
  }
}
