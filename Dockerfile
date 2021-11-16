FROM ubuntu:focal

COPY entrypoint.sh ./entrypoint.sh

RUN chmod +x entrypoint.sh
RUN apt update  \
        && apt install -y curl
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 -o get_helm.sh
RUN curl -L https://github.com/kubernetes/kompose/releases/download/v1.22.0/kompose-linux-amd64 -o kompose
RUN chmod +x kompose
RUN chmod +x get_helm.sh
RUN mv ./kompose /usr/local/bin/kompose
RUN ./get_helm.sh

ENTRYPOINT ["./entrypoint.sh"]
