from pydantic import BaseSettings

class Settings(BaseSettings):
    app_name: str = "Business Analytics Platform"
    environment: str = "development"
    backend_url: str = "http://localhost:8000"

    class Config:
        env_file = ".env"

settings = Settings()
