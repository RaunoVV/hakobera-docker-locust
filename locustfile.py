from locust import HttpLocust, TaskSet, task
from locust.events import request_failure
import resource
resource.setrlimit(resource.RLIMIT_NOFILE, (999999, 999999))

class WebsiteTasks(TaskSet):
    
    @task
    def index(self):
        self.client.get("/")
        

class WebsiteUser(HttpLocust):
    task_set = WebsiteTasks
    min_wait = 5000
    max_wait = 15000

def on_failure(request_type, name, response_time, exception, **kwargs):
    print exception.request.url
    print exception.message
    if exception.response:
      print exception.response.status_code
      print exception.response.content

request_failure += on_failure
