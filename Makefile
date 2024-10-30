up:
	docker-compose -p flink-cdc-poc -f docker-compose.yml up -d
	docker-compose -p flink-cdc-poc exec -T postgres createdb -U postgres main
	docker-compose -p flink-cdc-poc exec -T postgres psql -U postgres -d main < ./setup_scripts/db_setup.sql

down:
	docker-compose -p flink-cdc-poc -f docker-compose.yml down