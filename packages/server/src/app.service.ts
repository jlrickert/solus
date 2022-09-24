import { Injectable } from "@nestjs/common";
import { message } from "@solus/ecs";

@Injectable()
export class AppService {
    getHello(): string {
        return message();
    }
}
