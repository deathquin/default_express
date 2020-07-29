# 어떤 이미지를 기반으로 생성할지 설정
# Dockerfile로 이미지를 생성할 때는 항상 기존에 있는 이미지를 기반으로 생성하기 때문에 FROM은 반드시 설정해야 합니다.
# ex) FROM ubuntu, FROM ubuntu:14.04 ..
# FROM <이미지> 또는 FROM <이미지>:<태그> 형식입니다.
FROM node:carbon

# 이미지를 생성한 사람의 정보를 설정합니다. 형식은 자유이며 보통 다음과 같이 이름과 이메일을 입력합니다.
# MAINTAINER <작성자 정보>
MAINTAINER Dong Yeong Kim deathquin@kaist.ac.kr

# RUN은 FROM에서 설정한 이미지 위에서 스크립트 혹은 명령을 실행합니다. 여기서 RUN으로 실행한 결과가 새 이미지로 생성되고, 실행 내역은 이미지의 히스토리에 기록됩니다.
# app 폴더 만들기 - NodeJS 어플리케이션 폴더
# ex) RUN apt-get install -y nginx
#     RUN echo "Hello Docker" > /tmp/hello
#     RUN curl -sSL https://golang.org/dl/go1.3.1.src.tar.gz | tar -v -C /usr/local -xz
#     RUN git clone https://github.com/docker/docker.git
RUN mkdir -p /app

# winston 등을 사용할떄엔 log 폴더도 생성

# WORKDIR은 RUN, CMD, ENTRYPOINT의 명령이 실행될 디렉터리를 설정합니다.
# 어플리케이션 폴더를 Workdir로 지정 - 서버가동용
# WORKDIR <경로>
WORKDIR /app

# 앱 의존성 설치
# 가능한 경우(npm@5+) package.json과 package-lock.json을 모두 복사하기 위해
# 와일드카드를 사용
COPY package*.json ./

#서버 파일 복사 ADD [어플리케이션파일 위치] [컨테이너내부의 어플리케이션 파일위치]
#저는 Dockerfile과 서버파일이 같은위치에 있어서 ./입니다
#ADD ./ /app

#패키지파일들 받기
RUN npm install

# 앱 소스 추가
COPY . .

# EXPOSE는 호스트와 연결할 포트 번호를 설정합니다. docker run 명령의 --expose 옵션과 동일합니다.
# EXPOSE <포트 번호>
# ex) EXPOSE 80 443 형식의 두개로도 가능
EXPOSE 80

# 배포버젼으로 설정 - 이 설정으로 환경을 나눌 수 있습니다.
# ENV는 환경 변수를 설정합니다.
# ENV <환경 변수> <값>
ENV NODE_ENV=production

# CMD는 컨테이너가 시작되었을 때 스크립트 혹은 명령을 실행합니다. 즉 docker run 명령으로 컨테이너를 생성하거나,
# docker start 명령으로 정지된 컨테이너를 시작할 때 실행됩니다. CMD는 Dockerfile에서 한 번만 사용할 수 있습니다.
# 서버실행 node bin/www
# CMD <명령>
# CMD ["<실행 파일>", "<매개 변수1>", "<매개 변수2>"]
CMD ["node", "bin/www"]