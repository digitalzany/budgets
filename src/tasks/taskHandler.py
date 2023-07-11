from enum import Enum
from django.core.cache import cache
from uuid import uuid1


class Task:
    
    def __init__(self):
        self.task_progress = TaskProgress()

    def start(self, method):
        """
        Triggers the task and returns it's id
        """
        method(self.task_progress)
        
        return self.task_progress.get_task_id()


class TaskProgress:

    def __init__(self):
        self.task_id = str(uuid1())
        cache.set(self.task_id, self, timeout=None)
        self.status = ""
        self.message = ""

    def set(self, status: Enum, message: str = None):
        self.status = status.value
        self.message = message
        cache.set(self.task_id, self, timeout=None)

    def get_task_id(self):
        return self.task_id
    
    def get_task_status(self):
        return self.status
    
    def get_task_message(self):
        return self.message


class Status(Enum):
    STARTED = "STARTED"
    RUNNING = "RUNNING"
    FAILED = "FAILED"
    SUCCESS = "SUCCESS"
