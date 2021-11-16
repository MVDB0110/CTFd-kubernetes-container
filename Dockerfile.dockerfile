COPY entrypoint.sh ./entrypoint.sh
        entrypoint.sh

RUN RUN chmod +x entrypoint.sh
RUN RUN apt update  \
        && apt install -y curl
RUN RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 -o get_helm.sh
RUN RUN curl -L https://github.com/kubernetes/kompose/releases/download/v1.22.0/kompose-linux-amd64 -o kompose
RUN RUN chmod +x kompose
RUN RUN chmod +x get_helm.sh
RUN RUN mv ./kompose /usr/local/bin/kompose
RUN RUN ./get_helm.sh

ENTRYPOINT ["./entrypoint.sh"]