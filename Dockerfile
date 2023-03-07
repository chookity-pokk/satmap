FROM ubuntu-latest
RUN apt update
RUN apt upgrade -y
RUN apt install make
# haskell 
RUN apt install -y haskell-platform

# gmp 
RUN apt install -y wget
RUN apt install -y m4
WORKDIR /home/tools/
RUN wget https://gmplib.org/download/gmp/gmp-6.0.0a.tar.bz2
RUN bzip2 -d gmp-6.0.0a.tar.bz2
RUN tar -xof gmp-6.0.0a.tar
WORKDIR /home/tools/gmp-6.0.0
RUN ./configure
RUN make && make check && make install

# Clone Repo and Build
RUN git clone https://github.com/qqq-wisc/satmap.git  --recurse-submodules
RUN cd satmap/lib/Open-WBO-Inc/
RUN make -j $(nproc) r


#Satmap
RUN python3 src/satmap.py circ.qasm --arch tokyo
