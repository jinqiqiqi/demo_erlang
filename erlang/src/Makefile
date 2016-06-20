.SUFFIXES: .erl .beam
	
.erl.beam:
	erlc -W $<
	
ERL = erl -boot start_clean

MODS = geometry afile_server area_server processes kvs lib_misc test

all: compile
	${ERL} -s geometry test
	
compile: ${MODS:%=%.beam}
	
clean:
	rm -frv *.beam erl_crash.dump