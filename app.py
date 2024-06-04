from fastapi import FastAPI

app = FastAPI()


@app.get("/info")
def read_info():
    return {"info": "This is a FastAPI application running on EC2 with Auto Scaling Group and Load Balancer."}


@app.get("/")
def read_root():
    return {"Hello": "World"}

