package com.ibm.pojo.ImmunizationRecommendationResource;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;

public class SupportingPatientInformation {
    public String reference;

    public String getReference() { return reference; }

    public void setReference(String reference) { this.reference = reference; }

    public String toString()
    {
        return ReflectionToStringBuilder.toString(this);
    }

}