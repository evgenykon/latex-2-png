FROM nginx:1.27-alpine

COPY index.html plot.html draw.html pdf.html /usr/share/nginx/html/
COPY README.md /usr/share/nginx/html/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1/ || exit 1
