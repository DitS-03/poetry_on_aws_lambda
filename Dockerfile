
FROM amazon/aws-lambda-python:3.9 AS base_image

ADD ./lambda_function.py ${LAMBDA_TASK_ROOT}
ADD ./pyproject.toml     ${LAMBDA_TASK_ROOT}
ADD ./poetry.lock        ${LAMBDA_TASK_ROOT}
ADD ./src                ${LAMBDA_TASK_ROOT}/src

FROM base_image


RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py > get-poetry.py; \
    POETRY_HOME=/etc/poetry python get-poetry.py; \
    chmod -R 755 /etc/poetry; \
    /etc/poetry/bin/poetry config virtualenvs.in-project true; \
    /etc/poetry/bin/poetry install --no-interaction; \
    rm get-poetry.py;

ENV PATH /etc/poetry/bin:$PATH

CMD ["lambda_function.lambda_handler"] 