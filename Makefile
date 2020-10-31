.PHONY: all
all: dasm
all: dasm-stella
all: dasm-stella-pulseaudio

.PHONY: dasm
dasm: dasm/Dockerfile
	docker build -t zshift/dasm dasm

.PHONY: dasm-stella
dasm-stella: dasm
	docker build -t zshift/dasm:stella -f dasm/Dockerfile.stella dasm 

.PHONY: dasm-stella-pulseaudio
dasm-stella-pulseaudio: dasm-stella
	docker build -t zshift/dasm:stella-pulseaudio -f dasm/Dockerfile.stella.pulseaudio dasm 

