FROM docker.io/python:3.13 as build
WORKDIR /src
RUN pip install poetry
ADD . .
RUN poetry build

FROM docker.io/python:3.13-slim

WORKDIR /app
COPY --from=build /src/dist/*.whl .
RUN pip install *.whl && rm *.whl

ENTRYPOINT [ "/usr/local/bin/frontdoor-ipgroup-updater" ]
