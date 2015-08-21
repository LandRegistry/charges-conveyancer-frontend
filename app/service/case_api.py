import requests
from app.case.model import Case
from app import config


class CaseApi(object):
    case_endpoint = "{}/case".format(config.CASE_API_BASE_HOST)

    def get_case_client(self):
        return requests.get(self.case_endpoint).json()

    def get_cases(self):
        cases_json = self.get_case_client()
        return [Case.from_json(cases_json[id_]) for id_ in cases_json]

    def create_case(self, case_ref):
        payload = {
            "conveyancer_id": 1,
            "case_ref": case_ref
        }
        response = requests.post(self.case_endpoint, json=payload)

        if response.status_code == 201:
            return Case.from_json(response.json())
        else:
            response.raise_for_status()

    def update_case_with_deed(self, case_id, deed_id):
        payload = {
            "deed_id": deed_id
        }
        endpoint = "{case}/{case_id}/deed".format(
            case=self.case_endpoint,
            case_id=case_id
        )
        response = requests.post(endpoint, json=payload)

        if response.status_code == 200:
            return response
        else:
            response.raise_for_status()
