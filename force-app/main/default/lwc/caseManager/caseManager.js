import { LightningElement, api, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getCases from '@salesforce/apex/CaseController.getCases';
import saveCase from '@salesforce/apex/CaseController.saveCase';

export default class CaseManager extends LightningElement {
    @api recordId;
    cases = [];
    draftSubject = '';
    wiredCasesResult;
    selectedCaseId;

    @wire(getCases, { accountId: '$recordId' })
    wiredCases(result) {
        this.wiredCasesResult = result;
        if (result.data) {
            this.cases = result.data;
        } else if (result.error) {
            console.error('Error fetching cases:', result.error);
        }
    }

    handleSubjectChange(event) {
        this.draftSubject = event.target.value;
    }

    handleCaseSelect(event) {
        this.selectedCaseId = event.detail;
    }

    handleSave() {
        saveCase({ accountId: this.recordId, subject: this.draftSubject })
            .then(() => {
                this.draftSubject = '';
                return refreshApex(this.wiredCasesResult);
            })
            .catch((error) => {
                console.error('Error saving case:', error);
            });
    }
}