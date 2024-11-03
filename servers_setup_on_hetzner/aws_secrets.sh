#!/bin/bash -e

AWS_REGION=eu-west-1

usage() {
    echo "Usage: $0 -s SECRET_ID -f OUTPUT_FILE [-e]
where:
    -s  AWS secret ID
    -f  output file with .env or .json extension
    -e  add additional 'export' statement into the file" 1>&2
}

exit_abnormal() {
    usage
    exit 1
}

DO_EXPORT=false

while getopts "s:f:e" options; do
    case "${options}" in
    s)
        SECRET_ID=${OPTARG}
        ;;
    f)
        FILE=${OPTARG}
        ;;
    e)
        DO_EXPORT=true
        ;;
    *)
        exit_abnormal
        ;;
    esac
done

if test -z "$SECRET_ID"; then
    exit_abnormal
fi

if test -z "$FILE"; then
    exit_abnormal
fi

echo "Get secret: $SECRET_ID"
SECRET_STRING=$(aws secretsmanager get-secret-value --region ${AWS_REGION} --query SecretString --output text --secret-id "${SECRET_ID}")

FILE_NAME=$(basename -- "$FILE")
FILE_EXTENSION="${FILE_NAME##*.}"

case "${FILE_EXTENSION}" in
json)
    OUTPUT_STRING="${SECRET_STRING}"
    ;;
env)
    echo "Parse secret string: $SECRET_ID"
    echo "Add 'export' statement: $DO_EXPORT"
    if ${DO_EXPORT}; then
        OUTPUT_STRING=$(echo "${SECRET_STRING}" | jq -r 'keys[] as $k | "export \($k)=\(.[$k])"')
    else
        OUTPUT_STRING=$(echo "${SECRET_STRING}" | jq -r 'keys[] as $k | "\($k)=\(.[$k])"')
    fi
    ;;
*)
    exit_abnormal
    ;;
esac

echo "Output secret data into file: $FILE"
OUTPUT_DIR="$(dirname "${FILE}")"
mkdir -p "${OUTPUT_DIR}"
echo "${OUTPUT_STRING}" >"${FILE}"

