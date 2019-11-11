FROM alpine

LABEL "name"="github-push"
LABEL "maintainer"="Kevin Gimbel <k.gimbel@synoa.de>"
LABEL "version"="0.0.1"

LABEL "com.github.actions.name"="Git push for GitHub Actions"
LABEL "com.github.actions.description"="Runs 'git push' to GitHub in an Action"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="green"

COPY README.md LICENSE start.sh /

RUN apk add --no-cache git openssh-client

CMD ["/start.sh"]
