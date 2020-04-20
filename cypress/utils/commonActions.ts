import { v4 as uuidv4 } from 'uuid';
import * as fake from 'faker';

//Random email generate
export function randomEmail() {
    return 'dharmalingam.k+'+uuidv4()+'@egovernments.org'
}

export function randomGSTIN() {
    return fake.random.alphaNumeric(15).toLocaleUpperCase();
}
export function randomName() {
    return fake.name.firstName(8);
}

export function randomCompanyName() {
    return fake.company.companyName();
}
