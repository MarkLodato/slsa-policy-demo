# Policy template for SLSA.
# All templates imlement the `policy` package.

package policy

allow(policy_params, attester, predicateType, predicate, subject_name) {
  predicateType ==  "https://slsa.dev/provenance/v0.1"
  provenance := predicate

  level := compute_level(policy_params.recognized_builders, attester, provenance)
  level >= policy_params.expected_slsa_level

  source := provenance.materials[provenance.recipe.definedInMaterial]
  source.uri == policy_params.allowed_source_repos[_]
}

# Returns the actual level of the artifact.
compute_level(recognized_builders, attester, provenance) = level {
  # Compute the max level based on the builder.
  builder := recognized_builders[_]
  attester == builder.attester
  provenance.builder.id == builder.builder_id
  max_level := builder.max_slsa_level

  # TODO: Verify the other requirements at each level: parameterless at L4, etc.

  level = max_level
}
