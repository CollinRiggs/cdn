[1mdiff --git a/main-ms/main.js b/main-ms/main.js[m
[1mindex f7ca6b8..e4c5079 100644[m
[1m--- a/main-ms/main.js[m
[1m+++ b/main-ms/main.js[m
[36m@@ -1,6 +1,7 @@[m
 import { credentials, loadPackageDefinition } from "@grpc/grpc-js";[m
 import { loadSync } from "@grpc/proto-loader";[m
 import express from 'express';[m
[32m+[m[32mimport cors from 'cors';[m
 [m
 const REST_PORT = 5000;[m
 [m
[36m@@ -12,8 +13,9 @@[m [mconst projectsStub = new projectsProto.Projects('0.0.0.0:50051', credentials.cre[m
 [m
 const app = express();[m
 app.use(express.json());[m
[32m+[m[32mapp.use(cors());[m
 [m
[31m-app.use(express.static('public'));[m
[32m+[m[32mapp.use('/static', express.static('public'));[m
 [m
 app.get('/projects', (_, res) => {[m
     projectsStub.all({id: 0}, (err, projectStubs) => {[m
[36m@@ -41,4 +43,4 @@[m [mapp.get('/projects/:id', (req, res) => {[m
 [m
 app.listen(REST_PORT, () => {[m
     console.log(`RESTful API listening on port ${REST_PORT}`);[m
[31m-});[m
\ No newline at end of file[m
[32m+[m[32m});[m
[1mdiff --git a/package-lock.json b/package-lock.json[m
[1mindex d13af2b..95b08f6 100644[m
[1m--- a/package-lock.json[m
[1m+++ b/package-lock.json[m
[36m@@ -11,6 +11,7 @@[m
       "dependencies": {[m
         "@grpc/grpc-js": "^1.8.14",[m
         "@grpc/proto-loader": "^0.7.6",[m
[32m+[m[32m        "cors": "^2.8.5",[m
         "express": "^4.18.2"[m
       },[m
       "devDependencies": {[m
[36m@@ -359,6 +360,18 @@[m
       "resolved": "https://registry.npmjs.org/cookie-signature/-/cookie-signature-1.0.6.tgz",[m
       "integrity": "sha512-QADzlaHc8icV8I7vbaJXJwod9HWYp8uCqf1xa4OfNu1T7JVxQIrUgOWtHdNDtPiywmFbiS12VjotIXLrKM3orQ=="[m
     },[m
[32m+[m[32m    "node_modules/cors": {[m
[32m+[m[32m      "version": "2.8.5",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/cors/-/cors-2.8.5.tgz",[m
[32m+[m[32m      "integrity": "sha512-KIHbLJqu73RGr/hnbrO9uBeixNGuvSQjul/jdFvS/KFSIH1hWVd1ng7zOHx+YrEfInLG7q4n6GHQ9cDtxv/P6g==",[m
[32m+[m[32m      "dependencies": {[m
[32m+[m[32m        "object-assign": "^4",[m
[32m+[m[32m        "vary": "^1"[m
[32m+[m[32m      },[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">= 0.10"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
     "node_modules/date-fns": {[m
       "version": "2.30.0",[m
       "resolved": "https://registry.npmjs.org/date-fns/-/date-fns-2.30.0.tgz",[m
[36m@@ -697,6 +710,14 @@[m
         "node": ">= 0.6"[m
       }[m
     },[m
[32m+[m[32m    "node_modules/object-assign": {[m
[32m+[m[32m      "version": "4.1.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/object-assign/-/object-assign-4.1.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-rJgTQnkUnH1sFw8yT6VSU3zD3sWmu6sZhIseY8VX+GRu3P6F7Fu+JNDoXfklElbLJSnc3FUQHVe4cU5hj+BcUg==",[m
[32m+[m[32m      "engines": {[m
[32m+[m[32m        "node": ">=0.10.0"[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
     "node_modules/object-inspect": {[m
       "version": "1.12.3",[m
       "resolved": "https://registry.npmjs.org/object-inspect/-/object-inspect-1.12.3.tgz",[m
[1mdiff --git a/package.json b/package.json[m
[1mindex 251bae0..be84ca6 100644[m
[1m--- a/package.json[m
[1m+++ b/package.json[m
[36m@@ -13,6 +13,7 @@[m
   "dependencies": {[m
     "@grpc/grpc-js": "^1.8.14",[m
     "@grpc/proto-loader": "^0.7.6",[m
[32m+[m[32m    "cors": "^2.8.5",[m
     "express": "^4.18.2"[m
   },[m
   "devDependencies": {[m
