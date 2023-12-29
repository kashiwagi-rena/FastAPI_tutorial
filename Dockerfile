FROM python:3.12

# バッファリングを無効にすることでログの出力をすぐに表示するように設定
ENV PYTHONUNBUFFERED=1

# 作業ディレクトリを /src に設定
WORKDIR /src

# Poetryのインストール
RUN pip install poetry


# プロジェクトの依存関係をインストール
COPY pyproject.toml* poetry.lock* ./
# RUN poetry config virtualenvs.in-project true && poetry install --no-root
RUN poetry config virtualenvs.in-project true
RUN if [ -f pyproject.toml ]; then poetry install --no-root; fi 


# ソースコードをコンテナにコピー
COPY . .

# FastAPIアプリケーションのエントリポイント
ENTRYPOINT [ "poetry", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--reload" ]