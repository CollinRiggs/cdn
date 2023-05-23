import { loadPackageDefinition, Server, ServerCredentials } from "@grpc/grpc-js";
const PROTO_PATH = "./protos/projects.proto";
import { loadSync } from "@grpc/proto-loader";

import projectData from './projects.json' assert { type: 'json' };

const packageDefinition = loadSync(PROTO_PATH);
const projectsProto = loadPackageDefinition(packageDefinition);

function getProject(call, callback) {
    let project = projectData.find((project) => project.id === call.request.id);
    project._extra = JSON.stringify(project);
    if (project) callback(null, project);
    else {
        callback({
            message: "Project not found",
            code: grpc.status.INVALID_ARGUMENT
        });
    }
}

function getProjectStubs(_, callback) {
    callback(null, {
        projects: projectData.map(project => { return {
            id: project.id,
            title: project.title,
            iconUrl: project.iconUrl,
            tagline: project.tagline
        }})
    });
}

const server = new Server();
server.addService(projectsProto.Projects.service, {
    get: getProject,
    all: getProjectStubs
});
server.bindAsync('0.0.0.0:50051', ServerCredentials.createInsecure(), () => {
    server.start()
    console.log("Project service running on 0.0.0.0:50051")
});