import time
from tasks.taskHandler import Status
from uwsgidecorators import thread


@thread
def long_running_method(task_progress):
    """
    Sample long running method in a separate thread
    """
    task_progress.set(Status.STARTED)
    task_id = task_progress.get_task_id()
    
    try:
        for i in range(33):
            time.sleep(1)
            task_progress.set(Status.RUNNING, f"{ 3 * i + 1 }% has been processed")
            time.sleep(1)
            print(f'id: {task_id} - status: {task_progress.get_task_status()} - message: {task_progress.get_task_message()}')
    except Exception as _e:
        task_progress.set(Status.FAILED)
        print(_e)

    task_progress.set(Status.SUCCESS, "100% has been processed")
    print(f'id: {task_id} - status: {task_progress.get_task_status()} - message: {task_progress.get_task_message()}')
