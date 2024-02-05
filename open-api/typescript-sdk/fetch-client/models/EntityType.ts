/* tslint:disable */
/* eslint-disable */
/**
 * Immich
 * Immich API
 *
 * The version of the OpenAPI document: 1.94.1
 * 
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */


/**
 * 
 * @export
 */
export const EntityType = {
    Asset: 'ASSET',
    Album: 'ALBUM'
} as const;
export type EntityType = typeof EntityType[keyof typeof EntityType];


export function EntityTypeFromJSON(json: any): EntityType {
    return EntityTypeFromJSONTyped(json, false);
}

export function EntityTypeFromJSONTyped(json: any, ignoreDiscriminator: boolean): EntityType {
    return json as EntityType;
}

export function EntityTypeToJSON(value?: EntityType | null): any {
    return value as any;
}

