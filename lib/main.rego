package main

import data.policy
import data.subject

default allow = false

# Returns true if there exists an attestation that both matches the artifact and
# meets the policy.
#
# Inputs:
# - input.verified_attestations: Array[Object{"attesters": Array[string],
#                                             "statement": Statement}]
#     Collection of attestations whose signatures have been verified.
# - input.artifact: DigestSet
#     Artifact to be verified. Caller must only set acceptable hash algorithms.
# - input.policy_params: object
#     Parameters to pass to the policy.
allow {
  attestation := input.verified_attestations[_]
  attestation._type == "https://in-toto.io/Statement/v0.1"
  subject_name := subject.match(attestation.statement.subject,
                                input.artifact)
  attester := attestation.attester;
  policy.allow(input.policy_params,
               attester, 
               attestation.statement.predicateType,
               attestation.statement.predicate,
               subject_name)
}
