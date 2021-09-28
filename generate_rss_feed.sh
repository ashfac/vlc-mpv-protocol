#!/bin/bash

# Install jq before using this script
# sudo apt -y install jq

CHANNEL_URL=$1

# CHANNEL_URL="https://www.youtube.com/c/SouthMainAutoRepairAvoca/videos"

if [[ "${CHANNEL_URL}" != *"/videos"* ]]; then
    CHANNEL_URL=${CHANNEL_URL}/videos
fi

CHANNEL_TITLE=$( echo "${CHANNEL_URL//\/videos/}" )
CHANNEL_TITLE=$( echo "${CHANNEL_TITLE##*/}" )

WORK_DIR=rss-feeds
mkdir -p "${WORK_DIR}"

PLAYLIST_FILE=${WORK_DIR}/${CHANNEL_TITLE}.json
RSS_FEED=${WORK_DIR}/${CHANNEL_TITLE}.xml

echo "Downloading channel's playlist from YouTube..."

youtube-dl --skip-download --print-json ${CHANNEL_URL} | jq '{"id": .id,"title": .title,"duration": .duration,"upload_date": .upload_date,"channel_url": .channel_url,"thumbnail": .thumbnail,"description": .description}' > ${PLAYLIST_FILE}

echo "Generating XML file..."

# write header of rss feed
cat <<EOF > ${RSS_FEED}
<rss xmlns:media="http://search.yahoo.com/mrss/" xmlns:content="http://purl.org/rss/1.0/modules/content/" version="2.0">
<channel>
  <title>${CHANNEL_TITLE}</title>
  <link>${CHANNEL_URL}</link>
EOF

# read json file into an array
element_separator=$(echo -en "\t")
item_separator=$(echo -en "\r\b")

IFS="${item_separator}"
playlist=( $(jq -jr ".id, \"${element_separator}\",.title, \"${element_separator}\",.duration, \"${element_separator}\",.upload_date, \"${element_separator}\",.channel_url, \"${element_separator}\",.thumbnail, \"${element_separator}\", .description, \"${item_separator}\"" "${PLAYLIST_FILE}") )

# create xml file
for item in "${playlist[@]}"; do
    readarray -d "${element_separator}" -t element <<< "${item}"

    id="${element[0]}"
    upload_date="${element[3]}"

    if [ ${element[2]} -ge 3600 ]; then
        duration=$( date -d@${element[2]} -u +%H:%M:%S )
    else
        duration=$( date -d@${element[2]} -u +%M:%S )
    fi

    title=$(sed "s/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/\"/\&quot;/g; s/'/\&apos;/g;" <<< "${element[1]}")
    title=$(echo "${title} [${duration}]")
    channel_url=$(sed "s/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/\"/\&quot;/g; s/'/\&apos;/g;" <<< "${element[4]}")
    thumbnail=$(sed "s/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/\"/\&quot;/g; s/'/\&apos;/g;" <<< "${element[5]}")

    IFS=$(echo -en "\n\b") read -r -a description <<< "${element[6]}"
    description=$(sed "s/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/\"/\&quot;/g; s/'/\&apos;/g;" <<< "${description}")

    echo "    <item>" >> ${RSS_FEED}
    echo "        <title>${title}</title>" >> ${RSS_FEED}
    echo "        <pubDate>${upload_date}</pubDate>" >> ${RSS_FEED}
    echo "        <link>https://www.youtube.com/watch?v=${id}</link>" >> ${RSS_FEED}
    echo "        <description>${description}</description>" >> ${RSS_FEED}
    echo "        <media:content url=\"${thumbnail}\" type=\"image/webp\" medium=\"image\">" >> ${RSS_FEED}
    echo "          <media:thumbnail url=\"${thumbnail}\"/>" >> ${RSS_FEED}
    echo "          <media:title>${title}</media:title>" >> ${RSS_FEED}
    echo "        </media:content>" >> ${RSS_FEED}
    echo "    </item>" >> ${RSS_FEED}

done

cat <<EOF >> ${RSS_FEED}
</channel>
</rss>
EOF

echo "Done"
