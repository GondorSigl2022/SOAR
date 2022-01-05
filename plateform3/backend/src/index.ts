import { APIGatewayProxyEvent, APIGatewayProxyHandler } from 'aws-lambda';
import { AWSError } from 'aws-sdk';
import { ScanOutput } from 'aws-sdk/clients/dynamodb';

const AWS = require('aws-sdk');
AWS.config.update({ region: 'us-east-1' });
const docClient = new AWS.DynamoDB.DocumentClient();

const handleGetCocktailRequest = async () => {
    const queryResult: ScanOutput = await new Promise((resolve, reject) => {
        docClient.scan(
            { TableName: 'cocktails', Limit: 100 },
            (err: AWSError, data: ScanOutput) => {
                if (err) {
                    console.error(err);
                    reject(err);
                } else {
                    resolve(data);
                }
            });
    });

    return {
        statusCode: 200,
        headers: {
            'content-type': 'application/json'
        },
        body: JSON.stringify(queryResult.Items),
    };
};

const handleCreateCocktailRequest = async (event: APIGatewayProxyEvent) => {
    let requestBodyJson = '';
    {
        if (event.isBase64Encoded) {
            requestBodyJson = (Buffer.from(event.body ?? '', 'base64')).toString('utf8');
        } else {
            requestBodyJson = event.body ?? '';
        }
    }

    const requestBodyObject = JSON.parse(requestBodyJson) as { id: string, name : string, ingredients: string };

    await new Promise((resolve, reject) => {
        docClient.put(
            {
                TableName: 'cocktails',
                Item: {
                    id: requestBodyObject.id,
                    name: requestBodyObject.name,
                    ingredients: requestBodyObject.ingredients
                }
            },
            (err: AWSError) => {
                if (err) {
                    console.error(err);
                    reject(err);
                } else {
                    resolve(null);
                }
            });
    });

    return {
        statusCode: 201,
        headers: {
            'content-type': 'text/plain'
        },
        body: 'Created.',
    };
};

export const handler: APIGatewayProxyHandler = async (event) => {
    console.log('Received event', event);

    const routeKey = `${event.httpMethod} ${event.pathParameters?.proxy}`;

    if (routeKey === 'GET cocktails/') {
        return handleGetCocktailRequest();
    }

    if (routeKey === 'POST cocktails/') {
        return handleCreateCocktailRequest(event);
    }

    return {
        statusCode: 404,
        body: `No handler for routeKey ${routeKey}.`,
    };
};