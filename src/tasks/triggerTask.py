from tasks.taskHandler import Task
from tasks.longMethod import long_running_method
import uwsgi


task_id = Task().start(long_running_method)
print(f'New thread in a worker: {uwsgi.worker_id()}')
print(f'Started task with id: {task_id}')
