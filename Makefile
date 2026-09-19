IMAGE ?= latex-2-png
NAME  ?= latex-2-png
PORT  ?= 8080

.PHONY: help build run stop down logs shell clean

help:
	@echo "make build   - собрать образ $(IMAGE)"
	@echo "make run     - запустить контейнер на http://localhost:$(PORT)"
	@echo "make stop    - остановить контейнер"
	@echo "make down    - остановить и удалить контейнер"
	@echo "make logs    - логи контейнера"
	@echo "make shell   - sh внутри контейнера"
	@echo "make clean   - удалить образ"

build:
	docker build -t $(IMAGE) .

run: build
	@docker rm -f $(NAME) >/dev/null 2>&1 || true
	docker run -d --name $(NAME) -p $(PORT):80 $(IMAGE)
	@echo "Открой http://localhost:$(PORT)/"

stop:
	@docker stop $(NAME) >/dev/null 2>&1 || true

down:
	@docker rm -f $(NAME) >/dev/null 2>&1 || true

logs:
	docker logs -f $(NAME)

shell:
	docker exec -it $(NAME) sh

clean: down
	@docker rmi -f $(IMAGE) >/dev/null 2>&1 || true
