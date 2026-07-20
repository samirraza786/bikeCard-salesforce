import { LightningElement, api } from 'lwc';

export default class ChildList extends LightningElement {
    @api items = [];

    handleCaseClick(event) {
        const caseId = event.currentTarget.dataset.id;
        const selectEvent = new CustomEvent('caseselect', {
            detail: caseId
        });
        this.dispatchEvent(selectEvent);
    }
}