FROM ubuntu:latest
RUN apt-get update && apt-get install -y \
	git \
	wget \
	vim 

WORKDIR /opt
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh && \
	sh /opt/Anaconda3-2020.07-Linux-x86_64.sh -b -p /opt/anaconda3 && \
	rm -f Anaconda3-2020.07-Linux-x86_64.sh && \
	wget https://download.java.net/java/GA/jdk15.0.1/51f4f36ad4ef43e39d0dfdbaf6549e32/9/GPL/openjdk-15.0.1_linux-x64_bin.tar.gz && \
	tar -zxvf openjdk-15.0.1_linux-x64_bin.tar.gz && \
	rm -f openjdk-15.0.1_linux-x64_bin.tar.gz

ENV PATH /opt/anaconda3/bin:$PATH
ENV PATH /opt/jdk-15.0.1/bin:$PATH
RUN git clone https://github.com/SpencerPark/IJava.git && \
	pip install --upgrade pip
WORKDIR /opt/IJava/
RUN ./gradlew installKernel
WORKDIR /usr/src/myApp
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]