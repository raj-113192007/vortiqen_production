export declare class CreateSectionDto {
    name: string;
}
export declare class CreateClassDto {
    name: string;
    monthlyFee?: number;
    sections: CreateSectionDto[];
}
