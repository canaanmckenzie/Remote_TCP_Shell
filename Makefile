.PHONY: execute
execute:
	cd executor && cargo run

.PHONY: dump_shellcode
dump_shellcode:
	objdump -D -b binary -mi386 -Mx86-64 -Mintel -z shellcode.bin

.PHONY: fmt
fmt:
	cd executor && cargo fmt

.PHONY: reverse_tcp
reverse_tcp: 
	cd reverse_tcp && cargo build --release
	strip -s reverse_tcp/target/release/reverse_tcp
	objcopy -O binary reverse_tcp/target/release/reverse_tcp shellcode.bin

.PHONY: run_tcp
run_tcp: reverse_tcp execute