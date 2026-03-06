import pandas as pd
from fastapi import UploadFile


def load_csv(file: UploadFile) -> pd.DataFrame:
    df = pd.read_csv(file.file)
    df.columns = [col.strip().lower().replace(" ", "_") for col in df.columns]
    return df
