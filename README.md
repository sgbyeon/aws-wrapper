# aws-wrapper
* aws cli 는 사용자 디렉토리 하위($HOME/.aws/)에 크리덴셜 정보를 plain-text로 저장하기 때문에 보안 측면에서 바람직하지 못함
* aws를 배시 스크립트로 warpping(aws cli 원본을 aws.orig로 이동) 하고, 스크립트 내에서 export 를 이용 크리덴셜 정보를 선언함
* script는 non-interactive shell 이기 때문에 .bashrc 를 실행하지 않음, 따라서 export를 스크립트 내에서 실행하게 되면 해당 스크립트가 실행 될 동안만 환경 변수를 가지고 있게 됨
* warpping한 스크립트는 [shc](https://github.com/neurobin/shc)로 컴파일하여 읽을 수 없게 만듬
* 해당 wrapper는 aws cli profile 기능은 제공하지 않음, 단순한 warpper임
* 리눅스 서버 버전으로 사용할 때 안전하게 aws cli를 사용하기 위함
* 윈도우, Mac 또는 리눅스 Desktop 버전이라면 오히려 aws-vault를 추천함
* 해당 wrapper는 Amazon Linux 2 를 기준으로 함

## ```aws-cli-wrapper.sh```
```
#!/bin/bash

export AWS_ACCESS_KEY_ID="<your access key id>"
export AWS_SECRET_ACCESS_KEY="<your screct accekk key>"
export AWS_DEFAULT_REGION="<your region>"

/usr/bin/aws.orig $@
```
---

## shc compile
```
yum install automake gcc
git clone https://github.com/neurobin/shc.git
cd shc
./configure
sed -i 's/-1.16//g' Makefile
make
mv src/shc /usr/bin/
cd ..
rm -rf shc
```
---

## 적용 방법
```
mv /usr/bin/aws{,.orig}
/usr/bin/shc -U -f asw-cli-wrapper.sh -o /usr/bin/aws
chmod 700 /usr/bin/aws # 반드시 실행 권한을 700으로 변경, 최소 other에 실행권한이 있으면 안됨(최소 750, 권장 700)
rm -fv aw-cli-wrapper.sh aws-cli-wrapper.sh.x.c # 반드시 삭제
```
---

## 삭제 방법
```
rm -fv /usr/bin/aws /usr/bin/shc
mv /usr/bin/aws{.orig,}
```
