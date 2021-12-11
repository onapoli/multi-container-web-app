all: comp

comp:
	@mkdir -p ~/data/website_vol ~/data/db_vol ~/data/registry_vol \
	&& docker-compose -f ./srcs/docker-compose.yml up -d

debug:
	@mkdir -p ~/data/website_vol ~/data/db_vol ~/data/registry_vol \
	&& docker-compose -f ./srcs/docker-compose.yml up

stop:
	@docker-compose -f ./srcs/docker-compose.yml stop

restart:
	@docker-compose -f ./srcs/docker-compose.yml restart

clean:
	@docker-compose -f ./srcs/docker-compose.yml down --volumes ; \
	sudo rm -rf ~/data \
	&& docker container prune --force ; docker image prune --force

.PHONY: all comp debug stop restart clean