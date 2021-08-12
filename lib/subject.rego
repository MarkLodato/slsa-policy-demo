package subject

# Generates the set of all subject names that match `artifact`. The caller must
# only set acceptable algorithm types on `artifact`.
#
# Types:
# - subject: Array[Object{"name": string, "digest": DigestSet}].
# - artifact: DigestSet
match(subject, artifact) = artifact_name {
  sub := subject[_]
  some alg
  sub.digest[alg] == artifact[alg]
  artifact_name := sub.name
}
