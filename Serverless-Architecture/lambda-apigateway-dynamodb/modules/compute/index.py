import json
import boto3
import os

# DynamoDBオブジェクトの初期化（関数の外で行うと再利用されて速い）
dynamodb = boto3.resource("dynamodb")
# 環境変数からテーブル名を取得（後ほどTerraformで設定します）
TABLE_NAME = os.environ.get("TABLE_NAME", "ImageMetadataTable")
table = dynamodb.Table(TABLE_NAME)


def handler(event, context):
    try:
        # 1. API Gatewayから届いたデータ(JSON)をパース
        # HTTP APIの場合、bodyにデータが入っています
        body = json.loads(event.get("body", "{}"))

        # 2. データの取り出し（今回の必須項目）
        filename = body.get("filename")
        image_url = body.get("image_url")
        s3_bucket = body.get("s3_bucket")

        # バリデーション（filenameがないとDynamoDBでエラーになる）
        if not filename:
            return {"statusCode": 400, "body": json.dumps({"error": "filename is required"})}

        # 3. DynamoDBへ書き込み
        # attributeで定義していない項目も、ここで自由に含められます
        table.put_item(
            Item={
                "filename": filename,  # Partition Key
                "image_url": image_url,  # 追加データ
                "s3_bucket": s3_bucket,  # 追加データ
                "timestamp": "2023-10-27",  # 自由に項目を増やせます
            }
        )

        # 4. 成功レスポンス
        return {
            "statusCode": 200,
            "body": json.dumps({"message": f"Success! {filename} saved to DynamoDB.", "data": body}),
        }

    except Exception as e:
        print(f"Error: {str(e)}")
        return {"statusCode": 500, "body": json.dumps({"error": "Internal Server Error"})}
