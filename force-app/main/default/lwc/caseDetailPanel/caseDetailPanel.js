import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import SUBJECT_FIELD from '@salesforce/schema/Case.Subject';
import STATUS_FIELD from '@salesforce/schema/Case.Status';
import CREATED_DATE_FIELD from '@salesforce/schema/Case.CreatedDate';
import CASE_NUMBER_FIELD from '@salesforce/schema/Case.CaseNumber';

const FIELDS = [SUBJECT_FIELD, STATUS_FIELD, CREATED_DATE_FIELD, CASE_NUMBER_FIELD];

export default class CaseDetailPanel extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    caseRecord;

    get subject() {
        return getFieldValue(this.caseRecord.data, SUBJECT_FIELD);
    }

    get status() {
        return getFieldValue(this.caseRecord.data, STATUS_FIELD);
    }

    get createdDate() {
        return getFieldValue(this.caseRecord.data, CREATED_DATE_FIELD);
    }

    get caseNumber() {
        return getFieldValue(this.caseRecord.data, CASE_NUMBER_FIELD);
    }

    get noSelection() {
        return !this.recordId;
    }

    get isLoading() {
        return !!this.recordId && !this.caseRecord.data && !this.caseRecord.error;
    }

    get hasError() {
        return !!this.caseRecord.error;
    }

    get hasData() {
        return !!this.caseRecord.data;
    }

    get errorMessage() {
        return this.caseRecord.error?.body?.message || 'Unable to load case';
    }
}