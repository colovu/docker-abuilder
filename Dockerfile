# Ver: 1.8 by Endial Fang (endial@126.com)
#

# 可变参数 ========================================================================

# 设置当前应用名称及版本
ARG app_name=builder
ARG app_version=3.14

# 设置默认仓库地址，默认为 阿里云 仓库
ARG registry_url="registry.cn-shenzhen.aliyuncs.com"

# 设置 apt-get 源：default / tencent / ustc / aliyun / huawei
ARG apt_source=aliyun

# 编译镜像时指定用于加速的本地服务器地址
ARG local_url=""


# 1. 生成镜像 =====================================================================
FROM ${registry_url}/colovu/alpine:${app_version}

# 声明需要使用的全局可变参数
ARG app_name
ARG app_version
ARG registry_url
ARG apt_source
ARG local_url

# 镜像所包含应用的基础信息，定义环境变量，供后续脚本使用
ENV APP_NAME=dbuilder

LABEL \
    "Version"="v${app_version}" \
	"Description"="Docker image for Builder based on Alpine." \
	"Dockerfile"="https://github.com/colovu/docker-${app_name}" \
	"Vendor"="Endial Fang (endial@126.com)"

# 选择软件包源(Optional)，以加速后续软件包安装
RUN select_source ${apt_source}

# 说明：
#	虽然原始镜像包含 wget, 但该版本存在问题，下载部分资源（如redis）会报错，因此安装官方完整版
RUN install_pkg sudo wget curl git ca-certificates iproute2 net-tools nano dpkg gnupg \
		dpkg-dev bash build-base cmake pkgconf \
		linux-headers cmocka-dev openssl-dev


CMD []