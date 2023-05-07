import { credentials, loadPackageDefinition } from "@grpc/grpc-js";
import { loadSync } from "@grpc/proto-loader";
import express from 'express';
import cors from 'cors';

const REST_PORT = 5000;

const PROJECT_PROTO_PATH = "./protos/projects.proto";
const projectPackageDefinition = loadSync(PROJECT_PROTO_PATH);
const projectsProto = loadPackageDefinition(projectPackageDefinition);

const projectsStub = new projectsProto.Projects('0.0.0.0:50051', credentials.createInsecure());

const app = express();
app.use(express.json());
app.use(cors());

app.use('/static', express.static('public'));

app.get('/projects', (_, res) => {
    projectsStub.all({ id: 0 }, (err, projectStubs) => {
        if (err) {
            res.status(500).send('Could not fetch projects');
            return;
        }
        res.send(projectStubs);
    });
});

app.get('/projects/:id', (req, res) => {
    if (!req.params.id) {
        res.status(400).send('Invalid project ID');
        return;
    }
    projectsStub.get({ id: req.params.id }, (err, project) => {
        if (err) {
            res.status(500).send('Could not fetch project');
            return;
        }
        res.send(project);
    });
});

app.listen(REST_PORT, () => {
    console.log(`RESTful API listening on port ${REST_PORT}`);
});
