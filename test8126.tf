test('should complete CLI Scan within the expected time',
    setTestInfo({
      description: 'CLI Scan should complete within the expected time',
      team: 'team:QA-Automation',
      category: ['performance'],

    }),
    async () => {
      const timeoutInMinutes: number = 15;
      await expect(() =>
        // TODO: `pollUntilValid` should return how much time it took to hit "valid",
        // so we won't have to use a custom time-measuring matcher.
        pollUntilValid({
          name: `Waiting for pull request "${pullRequestNumber}" to complete scanning...`,
          timeoutInMinutes: timeoutInMinutes,
          intervalTimeInMinutes: 0.3,
          func: async () => (await Api.github.database.getCommitStatus({ owner: ownerName, repository: repositoryName, ref: generatedBranchName })).data,
          validator: response => response.state === 'failure',
        }),
      ).toCompleteWithin(timeoutInMinutes * 60 * 1000);
    });
