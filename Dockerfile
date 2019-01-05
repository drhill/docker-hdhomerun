FROM lsiobase/alpine:3.8

ARG engineID

RUN \ 
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	curl && \
 echo "**** add hdhomerun_record engine ****" && \
 mkdir -p /app/hdhomerun && \
 curl -o /app/hdhomerun/hdhomerun_record -SL https://download.silicondust.com/hdhomerun/hdhomerun_record_linux && \
 chmod +x /app/hdhomerun/hdhomerun_record && \
 echo "**** setup config ****" && \
 echo "RecordPath=/data" >> /config/hdhomerun.conf && \
 echo "StorageID=$engineID" >> /config/hdhomerun.conf && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/* 

# add local files
COPY root/ /

# ports and volumes
EXPOSE 65001/udp 65002 
WORKDIR /app/hdhomerun
VOLUME /data
