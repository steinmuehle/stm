IMG:=jottr/middleman-stm

build:
	docker build -t $(IMG) .

clean:
	docker rmi $(IMG)

run:
	docker run -it -p 4567:4567 $(IMG)

.PHONY: build clean run
