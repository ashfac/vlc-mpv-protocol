#!/bin/bash

CHANNEL_URL=$1

# CHANNEL_URL="https://www.youtube.com/c/SouthMainAutoRepairAvoca/videos"

if [[ "${CHANNEL_URL}" != *"/videos"* ]]; then
    CHANNEL_URL=${CHANNEL_URL}/videos
fi

CHANNEL_TITLE=$( echo "${CHANNEL_URL//\/videos/}" )
CHANNEL_TITLE=$( echo "${CHANNEL_TITLE##*/}" )

WORK_DIR=rss-feeds
mkdir -p "${WORK_DIR}"

PLAYLIST=${WORK_DIR}/${CHANNEL_TITLE}.txt
RSS_FEED=${WORK_DIR}/${CHANNEL_TITLE}.xml

echo "Downloading channel's playlist from YouTube..."

youtube-dl --skip-download --get-title --get-id --flat-playlist ${CHANNEL_URL} > ${PLAYLIST}

echo "Generating XML file..."

cat <<EOF > ${RSS_FEED}
<rss version="2.0">
<channel>
  <title>${CHANNEL_TITLE}</title>
EOF

is_title=true
while IFS= read -r line
do
    if [ ! -z "${line}" ]; then
        if ${is_title} ; then
            # Replace all XML escape charachters
            line=$( echo "${line//&/&amp;}" )
            line=$( echo "${line//</&lt;}" )
            line=$( echo "${line//>/&gt;}" )
            line=$( echo "${line//\"/&quot;}" )
            line=$( echo "${line//\'/&apos;}" )

            echo "    <item>" >> ${RSS_FEED}
            echo "        <title>${line}</title>" >> ${RSS_FEED}
            is_title=false
        else
            echo "        <link>https://www.youtube.com/watch?v=${line}</link>" >> ${RSS_FEED}
            echo "    </item>" >> ${RSS_FEED}
            is_title=true
        fi
    fi
done < ${PLAYLIST}

rm ${PLAYLIST}

echo "Done"

cat <<EOF >> ${RSS_FEED}
</channel>
</rss>
EOF
